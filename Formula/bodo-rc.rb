# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1019.4064-rc/bodo-darwin-arm64"
  version "2026.1019.4064-rc"
  sha256 "dd8e2b75452b8674406b0844d661c3cc4259dfc077eae3e47ee2125031e89040"
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
      url "https://cli.bodo-app.com/v/2026.1019.4064-rc/bodo-linux-arm64"
      sha256 "d1b2dd65dc67328ea65ec6d6b8ac2113a31ddcbad766e88f890c2eaa955a3065"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1019.4064-rc/bodo-linux-x64"
      sha256 "3d1d648cd6a8dde19cb4c5269e34397c055bf2ea05db4307a367c2f428e0abc6"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
