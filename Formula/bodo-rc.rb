# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1021.4163-rc/bodo-darwin-arm64"
  version "2026.1021.4163-rc"
  sha256 "226e33230a0db5c5d49078a1b95ce8e534eae3590a7b4fcb967e5ffc21efa55d"
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
      url "https://cli.bodo-app.com/v/2026.1021.4163-rc/bodo-linux-arm64"
      sha256 "b14f5e19053273e1365ca1db843a5ea38dc8c21bdb8295e064afcc680583a603"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1021.4163-rc/bodo-linux-x64"
      sha256 "1893cb4ddedade92c33e4e839d6bd36ee18346866acd7f5d7e111b60672363eb"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
