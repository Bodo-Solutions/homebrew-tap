# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1026.4451-rc/bodo-darwin-arm64"
  version "2026.1026.4451-rc"
  sha256 "4c27c94c630bed4bfafcdfd40df8c913409ca3a03997d020b2aa766fa00ea84f"
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
      url "https://cli.bodo-app.com/v/2026.1026.4451-rc/bodo-linux-arm64"
      sha256 "86a413e9c1d48c4f45137b51749c1bf37c9239fe9903ec097d215aabefc9e26e"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1026.4451-rc/bodo-linux-x64"
      sha256 "a3b2d704fd9497f401dca6cdbc4f7a8c7eaebf565baae6ba9604551b439bec90"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
