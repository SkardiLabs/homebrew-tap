# Homebrew formula template for the skardi CLI.
#
# This file is NOT a working formula: the VERSION/SHA256 tokens are filled
# in by the `homebrew` job in .github/workflows/release.yml at release time and the
# rendered result is pushed to SkardiLabs/homebrew-tap (Formula/skardi.rb).
# Users then install with:
#
#   brew install skardilabs/tap/skardi
#
# Every url points at a tarball already attached to the GitHub Release, so the
# formula never rebuilds anything and stays in lockstep with the published
# artifacts. Homebrew derives the formula version from the literal tarball
# urls, so no explicit `version` stanza is needed (brew audit rejects it).
class Skardi < Formula
  desc "CLI for Skardi — federated SQL engine and YAML-driven API server"
  homepage "https://github.com/SkardiLabs/skardi"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/SkardiLabs/skardi/releases/download/v0.7.0/skardi-aarch64-apple-darwin.tar.gz"
      sha256 "a6d794d60dd4b349796d67fc696b80e648606a8c27d83ee8f09ef554f06b1aa7"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/SkardiLabs/skardi/releases/download/v0.7.0/skardi-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9d4d66abc3135539211215b65e08fbcab77fdc615e291c80b5f397c76c5757b7"
    end
    on_arm do
      url "https://github.com/SkardiLabs/skardi/releases/download/v0.7.0/skardi-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c2c690b0a861a29601eefacc0c4038091fbef88731db177e0566e24a95813130"
    end
  end

  def install
    bin.install "skardi"
  end

  def caveats
    <<~EOS
      To set up Claude Code, Codex and Cursor to use Skardi (skills, plus the
      MCP server), run install.sh with --agents-only; it does not reinstall
      the CLI:

        curl -fsSL https://raw.githubusercontent.com/SkardiLabs/skardi/main/install.sh | bash -s -- --agents-only
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/skardi --version")
  end
end
