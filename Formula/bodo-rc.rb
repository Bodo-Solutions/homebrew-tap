# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1026.4426-rc/bodo-darwin-arm64"
  version "2026.1026.4426-rc"
  sha256 "985b9290a21eec986389ef27c8571c3c1367103bd398a3252f176d5a6d6a04e9"
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
      url "https://cli.bodo-app.com/v/2026.1026.4426-rc/bodo-linux-arm64"
      sha256 "18b2d68cc75c7f3d2a51e43451b70fcc2188135d30854221b30937f5874d996b"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1026.4426-rc/bodo-linux-x64"
      sha256 "b8c5285d20b228cae2cdb00eda61e894613c8d8e00695efb76f5e7b6bb5ed21c"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
