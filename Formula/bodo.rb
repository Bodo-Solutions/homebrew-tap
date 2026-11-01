# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1101.4687/bodo-darwin-arm64"
  version "2026.1101.4687"
  sha256 "ba050fbe0116adbb88eb55c6c6a1f723aac2e59c366d14bed58f9b9b92737248"
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
      url "https://cli.bodo-app.com/v/2026.1101.4687/bodo-linux-arm64"
      sha256 "df854966c6ed582e730aa4a57d72d345639aeb542a6ca0092cc071e64457dd1b"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1101.4687/bodo-linux-x64"
      sha256 "09c5fce211316995fe3cc2b8c46924ac6ac9d6070a2b92333ef0de2d12f5dd41"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
