# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1012.3890-rc/bodo-darwin-arm64"
  version "2026.1012.3890-rc"
  sha256 "cb7f336887bc6ae251d4a4f7d436e42c99f3ba9f3ffcb33ceb3e672c16e0a1fa"
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
      url "https://cli.bodo-app.com/v/2026.1012.3890-rc/bodo-linux-arm64"
      sha256 "e9c7fb4a1075f131644196fe56362c263316570d8d529bca13cb81a05c671035"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1012.3890-rc/bodo-linux-x64"
      sha256 "1483ed0abbdc139f74c22329cd039c021111c2030d647005afe0ddf80d082070"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
