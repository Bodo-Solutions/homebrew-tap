# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1023.4267-rc/bodo-darwin-arm64"
  version "2026.1023.4267-rc"
  sha256 "eca717663c661f21d20b03abcea569d06858ecd8fa97c4bd2817a71a5459418b"
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
      url "https://cli.bodo-app.com/v/2026.1023.4267-rc/bodo-linux-arm64"
      sha256 "12ad07af6fe2c7cb848cfefd6e79991bee9a1d650d4cda90105361b153c464c2"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1023.4267-rc/bodo-linux-x64"
      sha256 "0e391ffc08b3c104939e5393e917f94da06004b55e9e5ebd4c77e10da9b43a9a"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
