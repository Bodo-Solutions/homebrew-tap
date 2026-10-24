# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1024.4349-rc/bodo-darwin-arm64"
  version "2026.1024.4349-rc"
  sha256 "8e2f911d77b4e749276a40ae5548b2553441078077b481eb0e582257d638e5d5"
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
      url "https://cli.bodo-app.com/v/2026.1024.4349-rc/bodo-linux-arm64"
      sha256 "d9367b16765c69125d95a4898191a4b71eff2605f50d5c3b8535ba6bf7eb29b6"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1024.4349-rc/bodo-linux-x64"
      sha256 "465715824b769a08f583323b376998839824b57979a408d4bf52d7a63d311ecd"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
