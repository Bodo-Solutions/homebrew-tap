# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1029.4551-rc/bodo-darwin-arm64"
  version "2026.1029.4551-rc"
  sha256 "862a841a8e9a33f9710bca9a35bb7f072d33220d35568dec993af2d390ce5ce0"
  license :cannot_represent

  livecheck do
    url "https://cli.bodo-app.com/rc/manifest.json"
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
      url "https://cli.bodo-app.com/v/2026.1029.4551-rc/bodo-linux-arm64"
      sha256 "07be5842b09bc0be82df5cf392a1268abc00591cd3dfd3fe15c7c73393db581f"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1029.4551-rc/bodo-linux-x64"
      sha256 "67148c5a2d0866207f4fc3a3f732beca95049bd8a9860554efce95298cd7ae0a"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
