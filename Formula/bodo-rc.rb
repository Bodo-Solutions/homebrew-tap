# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1022.4251-rc/bodo-darwin-arm64"
  version "2026.1022.4251-rc"
  sha256 "fd4d514e44054e63a531eaae99c7029104701af21c370be2a72b58cd761cbc19"
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
      url "https://cli.bodo-app.com/v/2026.1022.4251-rc/bodo-linux-arm64"
      sha256 "b70df03c031b465a77a90097fcbe3b6ce5ed86eb3df8c0b41d9c87efb2da96db"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1022.4251-rc/bodo-linux-x64"
      sha256 "df4c2cb4988821061889413e04929d7b9305597e11827c6405828ac92b21e462"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
