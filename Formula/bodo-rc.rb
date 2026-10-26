# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1026.4458-rc/bodo-darwin-arm64"
  version "2026.1026.4458-rc"
  sha256 "0c52d62df2aac57a4c65cf23e8aaf2676979bd9cdaaeafe39a637fabfc8586aa"
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
      url "https://cli.bodo-app.com/v/2026.1026.4458-rc/bodo-linux-arm64"
      sha256 "3de42c193f7b09fbc1ee5a0633ace32db7e6559683d551d94a7812075dba9e9e"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1026.4458-rc/bodo-linux-x64"
      sha256 "712c8a5a11c2d65ebf72a3a07de87be8cd1ed50ab70352a2c566d13285a94b3b"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
