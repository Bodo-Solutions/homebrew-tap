# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1017.4014/bodo-darwin-arm64"
  version "2026.1017.4014"
  sha256 "f851923c47a8765e9ff04151b87c7103e118d51231ddf99c7c6cf3f5b607e07a"
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
      url "https://cli.bodo-app.com/v/2026.1017.4014/bodo-linux-arm64"
      sha256 "d5a86a2818b1b8f4a8e905ea6e026bf0e5fa71106d695843a2368d3b1325ab05"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1017.4014/bodo-linux-x64"
      sha256 "6991fbd5e40abc6fd89add14608e1676cbd682c70dc9cb0e88a37fe3c72ac0be"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
