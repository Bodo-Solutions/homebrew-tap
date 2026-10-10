# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1010.3858-rc/bodo-darwin-arm64"
  version "2026.1010.3858-rc"
  sha256 "c75140b44a5b96dfd708c0a6d3797a7cc07458d01f2bedee8a917fe1495baffd"
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
      url "https://cli.bodo-app.com/v/2026.1010.3858-rc/bodo-linux-arm64"
      sha256 "6f1c5cb38f02827d6ab7c09405d40b2cfec6cd35af778fd2325e1a3f881c752c"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1010.3858-rc/bodo-linux-x64"
      sha256 "43189e72950fc3b58ed03c8c255e248aa0a03870b50a8866ec96a6718ad61a7f"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
