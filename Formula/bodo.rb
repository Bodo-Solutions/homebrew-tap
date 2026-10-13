# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1013.3948/bodo-darwin-arm64"
  version "2026.1013.3948"
  sha256 "ce2b5bb5589bfc1871c5ec0a48065ead03d25da5082e0c96097c293bce1443ae"
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
      url "https://cli.bodo-app.com/v/2026.1013.3948/bodo-linux-arm64"
      sha256 "61790d1acefe84e51646d4308e07d4cf997c7fdda83aa819beab7d7178f1071d"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1013.3948/bodo-linux-x64"
      sha256 "e586065898a540a26718fb6dae0a2240b454c199fdede8fa74c73570f5b13cb7"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
