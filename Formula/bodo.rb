# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1022.4259/bodo-darwin-arm64"
  version "2026.1022.4259"
  sha256 "ac58b168cce48379f22376b7df8ad0a1092acf92926a2a2b829f8815b4f69926"
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
      url "https://cli.bodo-app.com/v/2026.1022.4259/bodo-linux-arm64"
      sha256 "61636abd42e9c09a6f7bd991c6310b428b81dbf8f3f73577d7ebbbfe3fc58196"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1022.4259/bodo-linux-x64"
      sha256 "cc25e2c42eb2c1ed87ee70e594614edadbeefe39d878b38d59956c68c93ded8d"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
