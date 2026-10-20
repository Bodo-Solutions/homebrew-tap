# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1020.4133-rc/bodo-darwin-arm64"
  version "2026.1020.4133-rc"
  sha256 "875564e3338b8859fdb8c673b115c0e06cc82050f0fbdd08971a6e1e00d2a86a"
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
      url "https://cli.bodo-app.com/v/2026.1020.4133-rc/bodo-linux-arm64"
      sha256 "484f08baae93a33b3950703fad6995120cffb2d2bb0b22e0171bba18df0646f5"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1020.4133-rc/bodo-linux-x64"
      sha256 "1666b64de62cb6fc97f232c0dcdc90a1d325e2d2cb96dd700e7133255d9eea65"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
