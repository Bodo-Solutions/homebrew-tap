# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1019.4091-rc/bodo-darwin-arm64"
  version "2026.1019.4091-rc"
  sha256 "22c84836f2b4ce44836eca8db9ebd16b6a4ea3369bd75c1251760885546b8ab6"
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
      url "https://cli.bodo-app.com/v/2026.1019.4091-rc/bodo-linux-arm64"
      sha256 "ae33c8841e3e16ba38dbcbbbd10a50517ce2c9892569367e59769dbc1ed8629d"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1019.4091-rc/bodo-linux-x64"
      sha256 "4c7636aa5db9eb5044481f28776d276c3dfabc05fceb5fe3767a56742a300584"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
