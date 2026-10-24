# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1024.4356/bodo-darwin-arm64"
  version "2026.1024.4356"
  sha256 "be74e56925b9067f843a60ad3a3711c9dbc3ca57889bb6fc9c35484bd1ec9d86"
  license :cannot_represent

  livecheck do
    url "https://cli.bodo-app.com/stable/manifest.json"
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
      url "https://cli.bodo-app.com/v/2026.1024.4356/bodo-linux-arm64"
      sha256 "a968bc84057d524dd0fc4666c5d5696fba5175629133c4e4a5a70f58411907c1"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1024.4356/bodo-linux-x64"
      sha256 "8ccc1411ca4f1b83c110b1b512b5ba0ad0cbf07a0403b9dbf7cf334e16e2c812"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
