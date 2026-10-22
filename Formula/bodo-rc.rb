# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1022.4200-rc/bodo-darwin-arm64"
  version "2026.1022.4200-rc"
  sha256 "0372b9c3ecb124380cfa5a52d22717a1e361e42533a1a0e5013a300ceb4d264b"
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
      url "https://cli.bodo-app.com/v/2026.1022.4200-rc/bodo-linux-arm64"
      sha256 "481f3c561f1dbde67304645abc0507fbe859c31920c05bc449292191f7e178bf"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1022.4200-rc/bodo-linux-x64"
      sha256 "221aeff347553a1f331926be464fc654f7fb8702467f52f9514b5749a0b34758"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
