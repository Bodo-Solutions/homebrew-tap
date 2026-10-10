# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1010.3850/bodo-darwin-arm64"
  version "2026.1010.3850"
  sha256 "f43158e99ccc992ad7edcbad5056bd939868b5c5946873feb9e8be943962178b"
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
      url "https://cli.bodo-app.com/v/2026.1010.3850/bodo-linux-arm64"
      sha256 "45f1c78db6c19d79d3bb21c1cedf27744db38f13240542687538148f85ad81c1"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1010.3850/bodo-linux-x64"
      sha256 "57f4f1af21566459d31307882acd0176c4837d97a77e0468590647fad78e3c27"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
