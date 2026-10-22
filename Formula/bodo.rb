# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1022.4209/bodo-darwin-arm64"
  version "2026.1022.4209"
  sha256 "f135dbde3fcbf2995c76e886e8825c3457bf6d3edbb3904d573a3190ad001bd9"
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
      url "https://cli.bodo-app.com/v/2026.1022.4209/bodo-linux-arm64"
      sha256 "dd939e2b8ee319500165033b20156a30ff7c713ed0396a4c27064398e3954d93"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1022.4209/bodo-linux-x64"
      sha256 "e5cd2302f6cad60901c083739385d0fa5be890d581d17bf795f7ae30bf0aa658"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
