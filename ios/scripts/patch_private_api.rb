#!/usr/bin/env ruby
# frozen_string_literal: true

# REMOVES THE PRIVATE SELECTOR APPLE REJECTED THE BUILD FOR.
#
# App Review, 2026-10-26, submission 482b3afb-bd13-4d53-b20b-82161d72de59:
#
#   "The app uses or references the following non-public or deprecated APIs:
#    • RPSystemBroadcastPickerView.buttonPressed:"
#
# Two pinned plugins call it, both to start a ReplayKit broadcast
# programmatically:
#
#   flutter_webrtc 0.14.2  ios/Classes/FlutterRTCDesktopCapturer.m
#   livekit_client 2.4.9   ios/Classes/BroadcastManager.swift
#
# WHY PATCH RATHER THAN UPGRADE. Apple suggests updating the libraries, and
# upstream HAS fixed this — both projects now find the picker's UIButton subview
# and trigger it with the public sendActions API. But the fix arrived alongside
# livekit_client 2.4.9 -> 2.13.2 and flutter_webrtc 0.14.2 -> 1.6.3, a major
# version jump through the entire voice and video stack. Taking that upgrade to
# clear a review block would put calling at risk in the same build, so the
# UPSTREAM FIX ITSELF is applied here, character for character, and the version
# bump is left as its own piece of work.
#
# WHY A SCRIPT AND NOT AN EDIT. These sources live in ~/.pub-cache and reach the
# build through ios/.symlinks, so an edit is undone by any cache repair or a
# clean checkout on another machine. Run from the Podfile's post_install, this
# re-applies on every `pod install` and is idempotent.
#
# WHY THE APP DOES NOT NEED THE FEATURE AT ALL. Nothing in lib/ calls screen
# sharing (the only startBroadcast is NFC/HCE for contactless payments), and the
# Xcode project has no Broadcast Upload Extension target — so iOS screen sharing
# could not function even if it were reached. The code is dead weight that cost
# a review cycle.

PATCHES = [
  {
    name: 'flutter_webrtc',
    glob: 'flutter_webrtc-*/ios/Classes/FlutterRTCDesktopCapturer.m',
    find: <<~OBJC.freeze,
      SEL selector = NSSelectorFromString(@"buttonPressed:");
          if ([picker respondsToSelector:selector]) {
            [picker performSelector:selector withObject:nil];
          }
    OBJC
    replace: <<~OBJC.freeze
      // PUBLIC API ONLY — see ios/scripts/patch_private_api.rb.
          // Was a performSelector on a private RPSystemBroadcastPickerView
          // method, which App Review rejects. This is upstream's own
          // replacement: find the picker's button and tap it through UIKit.
          UIButton* broadcastButton = nil;
          for (UIView* subview in picker.subviews) {
            if ([subview isKindOfClass:[UIButton class]]) {
              broadcastButton = (UIButton*)subview;
              break;
            }
          }
          if (broadcastButton != nil) {
            [broadcastButton sendActionsForControlEvents:UIControlEventTouchUpInside];
          }
    OBJC
  },
  {
    name: 'livekit_client',
    glob: 'livekit_client-*/ios/Classes/BroadcastManager.swift',
    find: <<~SWIFT.freeze,
      let selector = NSSelectorFromString("buttonPressed:")
              guard view.responds(to: selector) else { return }
              view.perform(selector, with: nil)
    SWIFT
    replace: <<~SWIFT.freeze
      // PUBLIC API ONLY — see ios/scripts/patch_private_api.rb.
              // Was a perform() of a private RPSystemBroadcastPickerView method,
              // which App Review rejects. This is upstream's own replacement:
              // find the picker's button and tap it through UIKit.
              guard let button = view.subviews.compactMap({ $0 as? UIButton }).first
              else { return }
              button.sendActions(for: .touchUpInside)
    SWIFT
  }
].freeze

# The marker proving a file is already patched, so a re-run is a no-op.
MARKER = 'PUBLIC API ONLY — see ios/scripts/patch_private_api.rb'

pub_cache = ENV['PUB_CACHE'] || File.join(Dir.home, '.pub-cache')
roots = [
  File.join(pub_cache, 'hosted', 'pub.dev'),
  File.join(pub_cache, 'hosted', 'pub.dartlang.org')
]

applied = []
already = []
missing = []

PATCHES.each do |patch|
  paths = roots.flat_map { |r| Dir.glob(File.join(r, patch[:glob])) }
  if paths.empty?
    missing << patch[:name]
    next
  end

  paths.each do |path|
    source = File.read(path)

    if source.include?(MARKER)
      already << path
      next
    end

    unless source.include?(patch[:find])
      # The upstream text has moved on. Say so loudly rather than silently
      # shipping a binary that still carries the rejected symbol — a quiet
      # no-op here is another rejected submission a week later.
      warn "  ⚠ #{patch[:name]}: the expected code was not found in #{path}."
      warn '    Either the plugin was upgraded (check whether it still calls'
      warn "    buttonPressed: — if not, delete that entry) or the patch is stale."
      missing << patch[:name]
      next
    end

    File.write(path, source.sub(patch[:find], patch[:replace]))
    applied << path
  end
end

puts '→ private-API patch (RPSystemBroadcastPickerView.buttonPressed:)'
applied.each { |p| puts "  ✓ patched #{p.sub(Dir.home, '~')}" }
already.each { |p| puts "  · already patched #{p.sub(Dir.home, '~')}" }

unless missing.empty?
  warn "  ⚠ unresolved: #{missing.uniq.join(', ')}"
  # Not a hard failure: a developer without those plugins resolved yet must
  # still be able to run pod install. The verifier below is what gates a
  # release.
end

# Final proof, on the files themselves.
remaining = roots.flat_map do |r|
  PATCHES.flat_map { |p| Dir.glob(File.join(r, p[:glob])) }
end.select { |p| File.read(p).include?('buttonPressed:') }

if remaining.empty?
  puts '  ✓ no reference to buttonPressed: remains in the plugin sources'
else
  warn '  ✗ buttonPressed: STILL PRESENT in:'
  remaining.each { |p| warn "      #{p.sub(Dir.home, '~')}" }
  warn '    This build would be rejected again. Fix before archiving.'
  exit 1
end
