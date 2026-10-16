# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1016.4007-rc/bodo-darwin-arm64"
  version "2026.1016.4007-rc"
  sha256 "f7d15c2a96d65771ae76fd3838571cc695498fa13997925c96a232342eb33c15"
  license :cannot_represent

  livecheck do
    url "https://cli.bodo-app.com/rc/manifest.json"
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
      url "https://cli.bodo-app.com/v/2026.1016.4007-rc/bodo-linux-arm64"
      sha256 "14f7f3d2171a929c2c9acc53c76f6bc4003ff3b3dad62957bdbf37e2c710223a"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1016.4007-rc/bodo-linux-x64"
      sha256 "d9c2a522c5bebea819a46df857bada595237f884d4fee99e7744f8a91c1c874b"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
