# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1029.4596-rc/bodo-darwin-arm64"
  version "2026.1029.4596-rc"
  sha256 "de81e732ac05a946c52e5533ed7ee3607135c4163c5187470f1494833c9d69fb"
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
      url "https://cli.bodo-app.com/v/2026.1029.4596-rc/bodo-linux-arm64"
      sha256 "e2fd698a7d22d8c664505688b83d3b44e0d5168e5000dd7d7d3394e7a21b4c6d"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1029.4596-rc/bodo-linux-x64"
      sha256 "942958885d2c7a573c1f4a099a3e6757ed38c72f036cb0c7dc84e56ca60cb550"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
