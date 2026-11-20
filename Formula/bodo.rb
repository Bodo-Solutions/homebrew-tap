# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-channels.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1120.4758/bodo-darwin-arm64"
  version "2026.1120.4758"
  sha256 "42f208464009e14269ddbb806b7885d14ac63b20fde1caa5b1fe05c194ef89c1"
  license :cannot_represent

  livecheck do
    url "https://cli.bodo-app.com/stable/manifest.json"
    regex(/^v?(\d+(?:\.\d+)+(?:-rc)?)$/i)
    strategy :json do |json, regex|
      json["version"]&.[](regex, 1)
    end
  end

  on_macos do
    depends_on arch: :arm64 unless Hardware::CPU.in_rosetta2?
  end

  on_linux do
    on_arm do
      url "https://cli.bodo-app.com/v/2026.1120.4758/bodo-linux-arm64"
      sha256 "2bbe9e7029edcc89cf727528b2dccf1fc04a014e0890db8455e51e9d5ec4b89a"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1120.4758/bodo-linux-x64"
      sha256 "f93fc91f902e7f0ce8a5120c0cac3a452f2307ccb0218bfbefbeb10e18caf16f"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
