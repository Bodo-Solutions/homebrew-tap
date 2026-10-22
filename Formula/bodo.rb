# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1022.4224/bodo-darwin-arm64"
  version "2026.1022.4224"
  sha256 "38ac47f17165b26eb4d31fc6c082f509f8e03efd86e70587ec7a39b08f204988"
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
      url "https://cli.bodo-app.com/v/2026.1022.4224/bodo-linux-arm64"
      sha256 "f19eb2c0b57f3091d72bde305958a14eae1493c7a19f6ee7dc42617882386177"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1022.4224/bodo-linux-x64"
      sha256 "ce2dcc8a70fe45a2c04908a2bb0f61f89b69a9902c7b18b41e55f785d94d3ad8"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
