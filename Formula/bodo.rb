# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-channels.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1120.4759/bodo-darwin-arm64"
  version "2026.1120.4759"
  sha256 "5ad4aa8f5b7db81dc866dab807faa89056761d973dddb97291e2eabf1c2ed336"
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
      url "https://cli.bodo-app.com/v/2026.1120.4759/bodo-linux-arm64"
      sha256 "951e6865b4144440462787be63f2ae9ffc572c3c0a287478938f7292ce0e9398"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1120.4759/bodo-linux-x64"
      sha256 "9a92c14953a1a6303401c0a0f0af3896de7c7131f3b684ed2607dd03aa9606ba"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
