# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1009.3796-rc/bodo-darwin-arm64"
  version "2026.1009.3796-rc"
  sha256 "0f2feedf197605d7cb446759c67510a80f1c59c62a722b4ebc3d8634b77e1b40"
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
      url "https://cli.bodo-app.com/v/2026.1009.3796-rc/bodo-linux-arm64"
      sha256 "4aa41062b56bb76ed445c11496990fd390e09c57c4597b26bf606bc26f9c1af9"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1009.3796-rc/bodo-linux-x64"
      sha256 "6f001737a4b1b83de3ae9a9aee33d9e28b2bc517833065abf8c5ac6552e9506c"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
