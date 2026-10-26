# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1026.4469-rc/bodo-darwin-arm64"
  version "2026.1026.4469-rc"
  sha256 "e5ce13d9e1b0555198d2cae00bff9f143710852bc6548a03601d268db07502f1"
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
      url "https://cli.bodo-app.com/v/2026.1026.4469-rc/bodo-linux-arm64"
      sha256 "306a691a7428a7d2a47b4e1484b64cdd7bd89b9323bdc580b0d7e1f972d1f7fa"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1026.4469-rc/bodo-linux-x64"
      sha256 "590f37e6f075b6338ad82f8ecab3295cebbf9f4bb59faa6dc746daa6f59ef300"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
