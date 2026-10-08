# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1008.3741-rc/bodo-darwin-arm64"
  version "2026.1008.3741-rc"
  sha256 "e6dd443341509b82072be07571478e41a903b1fbe0dd491bf34a48e42d67825c"
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
      url "https://cli.bodo-app.com/v/2026.1008.3741-rc/bodo-linux-arm64"
      sha256 "26aaaa89c70910418a567ed86beae8fe93a69fc3e5452938be9405d9ba8be2bc"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1008.3741-rc/bodo-linux-x64"
      sha256 "08273448f85cdd8e70a5d92b4b62d93be14e271d926c04e9417cd5d4caa9fe68"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
