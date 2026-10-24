# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1024.4353-rc/bodo-darwin-arm64"
  version "2026.1024.4353-rc"
  sha256 "8cb593e0e693f7a5fadbaac39d94b9a6786a335a46353573f04b1834f9c40f9c"
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
      url "https://cli.bodo-app.com/v/2026.1024.4353-rc/bodo-linux-arm64"
      sha256 "94d730d9a1b9ed55cba83fa78e29c52be8e46bd35e6d56fed895dd005d8ca3cb"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1024.4353-rc/bodo-linux-x64"
      sha256 "bdebf4be71f63f19f78d286ef837bcde25bbe3d560a2a82847c5610ea6d25786"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
