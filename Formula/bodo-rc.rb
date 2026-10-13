# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1013.3937-rc/bodo-darwin-arm64"
  version "2026.1013.3937-rc"
  sha256 "0e289be1eaf81b7ed31e070dea815e8f18c3b87d64d91508b1ed23abf71355c8"
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
      url "https://cli.bodo-app.com/v/2026.1013.3937-rc/bodo-linux-arm64"
      sha256 "50c3403090fd3cc5e5b6936069dbb822dbd50619a3487867ffb54635227273a2"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1013.3937-rc/bodo-linux-x64"
      sha256 "eaed4da912b6b28091b401afa9d24cd2fcba43a7f153aa3a445d19134c743aaa"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
