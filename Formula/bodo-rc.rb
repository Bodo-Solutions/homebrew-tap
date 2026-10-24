# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1024.4337-rc/bodo-darwin-arm64"
  version "2026.1024.4337-rc"
  sha256 "5fdadc860d901c34a879f48bb2a6c02038aaaac1ea5e9ffd02e06cd44f472346"
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
      url "https://cli.bodo-app.com/v/2026.1024.4337-rc/bodo-linux-arm64"
      sha256 "4de90601c3dece64452adc5fbad58f603a7dd074712ea2c926a8e69894bc2825"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1024.4337-rc/bodo-linux-x64"
      sha256 "0cd2d970920a07184807dce954a04eb99a3f168c82a2188b645186c98e8149b8"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
