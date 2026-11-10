# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1110.4717/bodo-darwin-arm64"
  version "2026.1110.4717"
  sha256 "5a08d7400f069117451047282bf47e9f37d2de9e78363bf4d592cffd1ee89845"
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
      url "https://cli.bodo-app.com/v/2026.1110.4717/bodo-linux-arm64"
      sha256 "71d6c0c95c622dca183d3fec13fc6296af174d94116d91d85e034c5c1b3074e0"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1110.4717/bodo-linux-x64"
      sha256 "836bdb954a1bcab196362550db0e25ec080fc44aec8d432206c77b464cbac010"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
