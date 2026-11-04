# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1104.4696/bodo-darwin-arm64"
  version "2026.1104.4696"
  sha256 "1d0afbc4dde50ae9cca763e0bfd14af293dc90a1ad495a15746574878e961050"
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
      url "https://cli.bodo-app.com/v/2026.1104.4696/bodo-linux-arm64"
      sha256 "f65d993cb22d84ec57b539dc97628e12188ebf7cd79864cc9968c2faade81c6a"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1104.4696/bodo-linux-x64"
      sha256 "1e405153de3fbdd32265761aab25766d83721a8acc9f336dab62abdc42c34803"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
