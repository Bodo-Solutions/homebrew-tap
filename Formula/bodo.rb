# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1004.3591/bodo-darwin-arm64"
  version "2026.1004.3591"
  sha256 "a450ef0882b9e6d07d29b6e84b3699ec46a48df4bb856780abb95cc3366f8417"
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
      url "https://cli.bodo-app.com/v/2026.1004.3591/bodo-linux-arm64"
      sha256 "7a1d848d31fb98b185288c64a548c3e0f827ac628e93310cc53ef9177cd46e14"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1004.3591/bodo-linux-x64"
      sha256 "4d96075a5e3a8461888dd1adc01cb9ce35794b6708e69cb7499c5ad37efe9a12"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
