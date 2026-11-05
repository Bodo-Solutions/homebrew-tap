# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1105.4700/bodo-darwin-arm64"
  version "2026.1105.4700"
  sha256 "eea90e81e11c44e44610d6443ff6f70e2c85fcb79b14fcd81267b66786bf57d7"
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
      url "https://cli.bodo-app.com/v/2026.1105.4700/bodo-linux-arm64"
      sha256 "a84ab10a4784ee5a34cc5693d65bec31b429ac571f9a6bec75890511cec73508"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1105.4700/bodo-linux-x64"
      sha256 "195a49fb1feb8136a5227afdfb311b7a94d079a68410e436391250b88b7c78f2"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
