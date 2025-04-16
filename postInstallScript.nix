{ stdenv }:

''
  #!/usr/bin/env bash
  set -euo pipefail

  echo "Running architecture and linking checks on executables..."
  EXPECTED_ARCH="${builtins.replaceStrings [ "_" ] [ "-" ] stdenv.hostPlatform.uname.processor}"

  find $out -type f -executable | while read executable; do
    echo "Checking $executable..."

    FILE_OUTPUT=$(file "$executable")
    echo "  $FILE_OUTPUT"

    if echo "$FILE_OUTPUT" | grep -q "ELF"; then
      if ! echo "$FILE_OUTPUT" | grep -q "$EXPECTED_ARCH"; then
        echo "  ERROR: Wrong architecture for $executable"
        echo "  Expected: $EXPECTED_ARCH"
        exit 1
      fi

      if ! echo "$FILE_OUTPUT" | grep -E -q "static(ally linked|-pie linked)"; then
        echo "  ERROR: $executable is not statically linked"
        exit 1
      fi

      echo "  ✓ Correct architecture and statically linked"
    else
      echo "  → Skipping (not an ELF binary)"
    fi
  done

  echo "All executable checks passed!"
''
