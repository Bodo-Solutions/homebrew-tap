# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1028.4508-rc/bodo-darwin-arm64"
  version "2026.1028.4508-rc"
  sha256 "9a531ba2b9d1b351a7665722963a669eedc09659c231c865487d97086387fcbe"
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
      url "https://cli.bodo-app.com/v/2026.1028.4508-rc/bodo-linux-arm64"
      sha256 "2444abf9d2515d8574e0f553f5e6ef4469746740d613245727c08fa39327a5aa"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1028.4508-rc/bodo-linux-x64"
      sha256 "a91aa70ca095435d9c65dfe79ac9134e29232a477b4d0e14ff456b5d72d33b52"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
