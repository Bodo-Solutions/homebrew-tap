# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1111.4720/bodo-darwin-arm64"
  version "2026.1111.4720"
  sha256 "56454fcb7b83b186118ff37774f072fdb3d37da9f036952dae125b0d533106bd"
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
      url "https://cli.bodo-app.com/v/2026.1111.4720/bodo-linux-arm64"
      sha256 "06940e1bb629471354bda6a5a81df39a0f675f027a66e85d5609e9b70209d895"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1111.4720/bodo-linux-x64"
      sha256 "c060dc6cfe859b1d63fc2b4b1e0b9d7fb22ec005260f0b9de33ff1e0d653fe7b"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
