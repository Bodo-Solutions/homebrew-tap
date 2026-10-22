# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1022.4227-rc/bodo-darwin-arm64"
  version "2026.1022.4227-rc"
  sha256 "1455f38cbc1f4aa634848a42817d43eeb002ff3687d5cc94fd82908b0a707844"
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
      url "https://cli.bodo-app.com/v/2026.1022.4227-rc/bodo-linux-arm64"
      sha256 "41d8ff401b6384d4efbde0c276083a474c2f18f8fd75d7fd6f6f2edb8acfa2ae"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1022.4227-rc/bodo-linux-x64"
      sha256 "a55343fbfee71e9d358591591048f0504f47106cf6a7b0b6023c1c2f772ba7dc"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
