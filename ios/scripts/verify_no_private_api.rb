#!/usr/bin/env ruby
# frozen_string_literal: true

# PROVES THE SHIPPED BINARY CARRIES NO REJECTED PRIVATE SELECTOR.
#
# WHY THIS EXISTS SEPARATELY FROM patch_private_api.rb. That script patches the
# plugin SOURCES and then verifies the SOURCES. Apple rejects the BINARY. Those
# are not the same claim, and the gap between them is real:
#
#   * the patch runs from the Podfile's post_install, so it only re-applies on
#     `pod install` — an archive built against an already-installed Pods tree
#     never runs it;
#   * a compiled object or a cached Pods framework can outlive a source edit;
#   * the selector can arrive inside a PREBUILT pod, where there is no source
#     to patch at all (which is exactly the case Apple's own advice describes:
#     "If you do not have access to the libraries' source, the `strings` tool
#     can output a list of the methods the library calls");
#   * a plugin upgrade can reintroduce it, and the source patcher would warn
#     about text it could no longer find while the build carried the symbol.
#
# So this checks the artifact that is actually submitted, which is the only
# check that answers the question Apple asked. An ObjC selector referenced
# anywhere in a Mach-O lands as a C string in __TEXT,__objc_methname, so a
# plain scan finds it whether it was called via performSelector, a direct
# message send, or from Swift.
#
# Usage:
#   ruby verify_no_private_api.rb <path to .ipa | .xcarchive | .app>
#
# Exits non-zero, loudly, on any hit — the point is to fail the release BEFORE
# the upload rather than discover it in review a week later.

require 'tmpdir'
require 'shellwords'

# Selectors App Review has actually rejected this app for. Add to this list
# when a rejection names a new one; do not add speculative entries, because a
# false positive here blocks a release.
#
#   RPSystemBroadcastPickerView.buttonPressed:
#     App Review 2026-10-26, submission 482b3afb-bd13-4d53-b20b-82161d72de59.
#     Called by flutter_webrtc 0.14.2 and livekit_client 2.4.9 to start a
#     ReplayKit broadcast programmatically. See patch_private_api.rb — the app
#     does not use screen sharing at all (no Broadcast Upload Extension target
#     exists), so the code was dead weight that cost a review cycle.
FORBIDDEN = [
  'buttonPressed:'
].freeze

target = ARGV[0]
if target.nil? || !File.exist?(target)
  warn "usage: #{File.basename($PROGRAM_NAME)} <path to .ipa | .xcarchive | .app>"
  exit 2
end

# Resolve whatever we were given down to a directory holding Mach-O files.
def with_bundle(target)
  case File.extname(target)
  when '.ipa'
    Dir.mktmpdir('privapi') do |tmp|
      # -q quiet, -o overwrite. An IPA is a zip whose Payload/ holds the .app.
      unless system('unzip', '-q', '-o', target, '-d', tmp)
        warn "could not unzip #{target}"
        exit 2
      end
      yield tmp
    end
  else
    yield target
  end
end

hits = []
scanned = 0

with_bundle(target) do |root|
  Dir.glob(File.join(root, '**', '*'), File::FNM_DOTMATCH).each do |path|
    next unless File.file?(path)
    next if File.symlink?(path)

    # `file` is cheap next to `strings` on a 100MB+ framework, so filter first.
    kind = `file -b #{Shellwords.escape(path)} 2>/dev/null`
    next unless kind.include?('Mach-O')

    scanned += 1

    # STREAM, DO NOT SLURP. `strings` on a release framework emits tens or
    # hundreds of megabytes; reading that into a Ruby String per file is enough
    # to matter. It killed a real build: on 2026-11-02 the iOS 475 archive
    # exported successfully and was then OOM-killed inside this very check,
    # with the machine already 11.7G into swap. A release gate that can take
    # down the release is worse than the symbol it guards against.
    #
    # Piping into `grep -c` keeps the bytes in the pipe and brings back only a
    # count, so peak memory is a few KB regardless of binary size. grep -F for
    # a literal, -a to treat the stream as text (an ObjC selector is ASCII by
    # construction, and without -a grep can stop early on a NUL).
    FORBIDDEN.each do |sel|
      out = `strings #{Shellwords.escape(path)} 2>/dev/null | grep -acF -- #{Shellwords.escape(sel)}`
      count = out.to_s.strip.to_i
      hits << [path.sub(root, ''), sel, count] if count.positive?
    end
  end
end

puts '→ private-API verification (the BINARY, not the sources)'
puts "  scanned #{scanned} Mach-O file(s) in #{File.basename(target)}"

if hits.empty?
  FORBIDDEN.each { |sel| puts "  ✓ no reference to #{sel}" }
  puts '  ✓ safe to submit'
  exit 0
end

warn ''
warn '  ✗ REJECTED PRIVATE API IS IN THE BINARY. Do not submit this build.'
hits.each { |path, sel, count| warn "      #{count}x #{sel}  in #{path}" }
warn ''
warn '  Fix, in order:'
warn '    1. cd ios && pod install    (re-runs scripts/patch_private_api.rb)'
warn '    2. rebuild — a cached Pods framework or object file can outlive a'
warn '       source patch, so a clean build is part of the fix'
warn '    3. if it survives that, the symbol is in a PREBUILT pod: find it with'
warn '       `otool -ov <binary> | grep -B5 <selector>` and upgrade that pod'
exit 1
