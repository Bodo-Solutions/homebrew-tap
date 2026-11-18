# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-channels.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1118.4752/bodo-darwin-arm64"
  version "2026.1118.4752"
  sha256 "f52a17d849a5ac61488ed55500079e40c640544d62798112cf10165ec3024121"
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
      url "https://cli.bodo-app.com/v/2026.1118.4752/bodo-linux-arm64"
      sha256 "62dabbbe8f555fa19980f1267b4cddc311392bfdbfa89f55138a86476efeb26e"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1118.4752/bodo-linux-x64"
      sha256 "cac92add7d4f19a3c8b748c3948d8d56ebc6f2f33d478bdd8620bbf6afcf910f"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
