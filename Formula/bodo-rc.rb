# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1026.4448-rc/bodo-darwin-arm64"
  version "2026.1026.4448-rc"
  sha256 "68e75b82d0579b17634cb809a243250cb09874fe6278deb37851baf60c0de4df"
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
      url "https://cli.bodo-app.com/v/2026.1026.4448-rc/bodo-linux-arm64"
      sha256 "653c0dc2976f2995be110aa6be249ddb863dc9839f4c13718514b006132918cb"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1026.4448-rc/bodo-linux-x64"
      sha256 "ab5fb5031b990a70e95ecadad8b23589c077d4de747141ee471aead1db4554b2"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
