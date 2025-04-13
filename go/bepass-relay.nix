{ lib, file, buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "bepass-relay";
  version = "1.0.2";

  src = fetchFromGitHub {
    owner = "bepass-org";
    repo = "bepass-relay";
    rev = "v${version}";
    hash = "sha256-PuswUhNUulUlWf2l7qDbg1J7K/v0ktOPio4TJgZ8/Xg=";
  };

  env.CGO_ENABLED = 0;
  hardeningDisable = [ "pie" ];

  vendorHash = "sha256-Z4ecObGWFKS/K3By4KH0uX/vMzmRYA4cNxkej/TQHQ4=";

  ldflags = [
    "-s"
    "-w"
  ];
  subPackages = [ "." ];

  doCheck = false;
  doInstallCheck = true;
  nativeBuildInputs = [ file ];
  installCheckPhase = ''
    #!/usr/bin/env bash
    set -euo pipefail

    echo "Running architecture and linking checks on executables..."
    # Get the expected architecture (adjust as needed)
    # For example: "x86_64" for 64-bit x86, "aarch64" for ARM64
    EXPECTED_ARCH="x86_64"

    # Find all executable files recursively
    find $out -type f -executable | while read executable; do
      echo "Checking $executable..."

      # Run file command on the executable
      FILE_OUTPUT=$(file "$executable")
      echo "  $FILE_OUTPUT"

      # Check if it's an actual binary executable (not a script)
      if echo "$FILE_OUTPUT" | grep -q "ELF"; then
        # Check architecture
        if ! echo "$FILE_OUTPUT" | grep -q "$EXPECTED_ARCH"; then
          echo "  ERROR: Wrong architecture for $executable"
          echo "  Expected: $EXPECTED_ARCH"
          exit 1
        fi

        # Check if dynamically linked
        if echo "$FILE_OUTPUT" | grep -q "statically linked"; then
          echo "  ERROR: $executable is statically linked, expected dynamic linking"
          exit 1
        fi

        echo "  ✓ Correct architecture and dynamically linked"
      else
        echo "  → Skipping (not an ELF binary)"
      fi
    done

    echo "All executable checks passed!"
  '';

  meta = {
    homepage = "https://github.com/bepass-org/bepass-relay";
    license = lib.licenses.mit;
  };
}
