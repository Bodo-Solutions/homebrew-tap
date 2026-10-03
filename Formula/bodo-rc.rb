# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1003.3555-rc/bodo-darwin-arm64"
  version "2026.1003.3555-rc"
  sha256 "e4556567a52d80cd2e7ebe5a9643a7a0ac7ef2ba66622564c67952f1859aca37"
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
      url "https://cli.bodo-app.com/v/2026.1003.3555-rc/bodo-linux-arm64"
      sha256 "eea4650832f8647ce1855906a4a39454f85c8034edb1614f1f361fe53441a0c7"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1003.3555-rc/bodo-linux-x64"
      sha256 "9e94c5f0b51893936b482fe378d4d04e58af5dab5023a398cdb994aa09dab593"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
