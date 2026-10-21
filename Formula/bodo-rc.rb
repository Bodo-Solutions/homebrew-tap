# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1021.4170-rc/bodo-darwin-arm64"
  version "2026.1021.4170-rc"
  sha256 "d64907bb4ca23c7bc94dc254c799f8e4f6ad1998adf78f44d483fb88a9186873"
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
      url "https://cli.bodo-app.com/v/2026.1021.4170-rc/bodo-linux-arm64"
      sha256 "c97860f9610efcd7db3d01563ab439c0d6011b39147de3347cd337d26d5f7755"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1021.4170-rc/bodo-linux-x64"
      sha256 "eb470dbdddc597ce079f10f40f1a3ee7a2f03502114ee05818d1c79a8fecb847"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
