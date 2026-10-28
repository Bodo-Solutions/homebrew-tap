# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1028.4513-rc/bodo-darwin-arm64"
  version "2026.1028.4513-rc"
  sha256 "5a3f14be5958d3904f9a0b17913209f01183478e97857d7ccb1ad64e3adb9b6b"
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
      url "https://cli.bodo-app.com/v/2026.1028.4513-rc/bodo-linux-arm64"
      sha256 "98348d9645336ede601b27ef69aca5c9bf6b799f076b04a4fbd3610adc2cef62"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1028.4513-rc/bodo-linux-x64"
      sha256 "242812f900ebe7ee1dc46d5fd300848bed1544fcce16100655717cd88db772ce"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
