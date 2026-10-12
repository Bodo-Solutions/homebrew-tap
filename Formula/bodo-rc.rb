# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1012.3911-rc/bodo-darwin-arm64"
  version "2026.1012.3911-rc"
  sha256 "cfc02879c1d274fc0ed92d2ab038b5d2b4de46068935b3daef14a54e1739a834"
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
      url "https://cli.bodo-app.com/v/2026.1012.3911-rc/bodo-linux-arm64"
      sha256 "21c1caa7fdd05351dfd7b32077f62620a1746c4af58aeef0f5671627d350bf25"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1012.3911-rc/bodo-linux-x64"
      sha256 "83e4d5e8d5e68c967b5dc901ff510e20a7af4940e69de96e71d725b5a6a864a1"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
