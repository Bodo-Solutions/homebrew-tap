# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-channels.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1117.4745/bodo-darwin-arm64"
  version "2026.1117.4745"
  sha256 "8724180f3964ac40c1c1e863f282c481d1e23c7040b537aec6fa41adcc8c74c1"
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
      url "https://cli.bodo-app.com/v/2026.1117.4745/bodo-linux-arm64"
      sha256 "8e3724461c1eb61a40df9c7af2acc297e65b01942d0c142079cfed39fad5ce17"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1117.4745/bodo-linux-x64"
      sha256 "58dc59d0c72ee789dc52147d2d5cf58b71dda99082302e9422967876f7d3960d"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
