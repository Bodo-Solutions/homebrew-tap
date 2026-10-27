# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1027.4479-rc/bodo-darwin-arm64"
  version "2026.1027.4479-rc"
  sha256 "26d51bbcb22e686b251ec03e716d3d214e4c7bb0971dce23df6859662a6b9049"
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
      url "https://cli.bodo-app.com/v/2026.1027.4479-rc/bodo-linux-arm64"
      sha256 "00a69c488cd0945fdccfe70d1388393c1b54124366f5996caa6bc701b6fec5b2"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1027.4479-rc/bodo-linux-x64"
      sha256 "8748234e5f0cb59c8a399848271bdf08658471228045f7797064648e169a2b8e"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
