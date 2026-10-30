# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1030.4654-rc/bodo-darwin-arm64"
  version "2026.1030.4654-rc"
  sha256 "d0073119f6610e7239f3fe3d77ccb88fd43d537a50d407042a988c5bdda6fb54"
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
      url "https://cli.bodo-app.com/v/2026.1030.4654-rc/bodo-linux-arm64"
      sha256 "ceb913c517384d6f3a02f375975efd9c66418b2baa1f47a8e3f321fdc9cd7203"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1030.4654-rc/bodo-linux-x64"
      sha256 "1900aa781d1a1edf2e50503316315af531602fe41eb68db24a17a990a94acde7"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
