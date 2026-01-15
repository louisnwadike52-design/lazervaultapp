#!/usr/bin/env python3
"""
Script to automatically apply token rotation pattern to repository methods.
This wraps gRPC calls with executeWithTokenRotation() for automatic token refresh.
"""

import re
import sys

def apply_token_rotation_pattern(file_path):
    """
    Applies token rotation pattern to all methods in a repository implementation file.

    Pattern:
    - Find: `final callOptions = await _callOptionsHelper.withAuth();` followed by gRPC call
    - Replace: Wrap the gRPC call with `executeWithTokenRotation(() async { ... })`
    """

    with open(file_path, 'r') as f:
        content = f.read()

    # Pattern to match: callOptions declaration + gRPC client call
    # This will match from callOptions declaration through the gRPC call
    pattern = r'(\s+)(final callOptions = await _callOptionsHelper\.withAuth\(\);)\s+' \
              r'(final (?:request|response) = [^;]+;)\s+' \
              r'(final response = await _\w+\.(\w+)\([^)]+,\s+options: callOptions,?\s*\);)'

    def replacer(match):
        indent = match.group(1)
        call_options_line = match.group(2)
        request_line = match.group(3)
        grpc_call = match.group(4)
        method_name = match.group(5)

        # Build the replacement with token rotation wrapper
        return f"""{indent}// Use executeWithTokenRotation for automatic token refresh on auth errors
{indent}final response = await _callOptionsHelper.executeWithTokenRotation(() async {{
{indent}  {call_options_line}
{indent}  {request_line}
{indent}
{indent}  return await {grpc_call.replace('final response = await ', '')};
{indent}}});"""

    new_content = re.sub(pattern, replacer, content)

    # Count replacements made
    replacements = len(re.findall(pattern, content))

    if replacements > 0:
        with open(file_path, 'w') as f:
            f.write(new_content)
        print(f"✅ Updated {file_path}: {replacements} methods wrapped with token rotation")
        return True
    else:
        print(f"⚠️  No changes needed in {file_path}")
        return False

if __name__ == '__main__':
    files_to_update = [
        'lib/src/features/autosave/data/repositories/autosave_repository_impl.dart',
        'lib/src/features/identity/data/repositories/identity_repository_impl.dart',
        'lib/src/features/referral/data/repositories/referral_repository_impl.dart',
        'lib/src/features/support/data/repositories/support_repository_impl.dart',
    ]

    print("🔄 Starting automatic token rotation pattern application...\n")

    total_updated = 0
    for file_path in files_to_update:
        if apply_token_rotation_pattern(file_path):
            total_updated += 1

    print(f"\n✨ Done! Updated {total_updated}/{len(files_to_update)} files")
