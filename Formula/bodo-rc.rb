# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1028.4511-rc/bodo-darwin-arm64"
  version "2026.1028.4511-rc"
  sha256 "325797504ad8a317c7d79124906bd8bdaa2607c5b732fe29fe8c9d46b2da3fca"
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
      url "https://cli.bodo-app.com/v/2026.1028.4511-rc/bodo-linux-arm64"
      sha256 "02f46b5398064595691e4fc2302ce83c509a95254e48b6aa397a64fa8fb77f0d"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1028.4511-rc/bodo-linux-x64"
      sha256 "8b0866bb64b0238350131a1e96c26d591777dadabdc8aa2c922bd0cd8581c1e2"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
