# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1111.4722/bodo-darwin-arm64"
  version "2026.1111.4722"
  sha256 "5034dca4c77cef1dec43c145582a378d3d314d1e6b6b0771ad616c035ace32be"
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
      url "https://cli.bodo-app.com/v/2026.1111.4722/bodo-linux-arm64"
      sha256 "54d979dda2a851adefba7650842ba2f1caf792a70e46f56b612e7bb923ddace9"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1111.4722/bodo-linux-x64"
      sha256 "20d7b4391ebb1b6ac97721156d6a66b71d88ed4cc322d79d66f6c4933a59eae1"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
